import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @Binding var selectedPhotos: [UIImage]
    @State private var photoPickerItems: [PhotosPickerItem] = []
    @State private var showGallery = false
    @State private var selectedPhoto: UIImage?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Add Photos")
                .font(.headline)
                .foregroundColor(.white)
            
            // Photo Grid
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    // Selected Photos
                    ForEach(selectedPhotos, id: \.self) { photo in
                        PhotoThumbnail(image: photo) {
                            selectedPhoto = photo
                            showGallery = true
                        } onDelete: {
                            if let index = selectedPhotos.firstIndex(of: photo) {
                                selectedPhotos.remove(at: index)
                            }
                        }
                    }
                    
                    // Add Photo Button
                    PhotosPicker(selection: $photoPickerItems,
                               maxSelectionCount: 5 - selectedPhotos.count,
                               matching: .images) {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                            Text("Add Photo")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        .frame(width: 100, height: 100)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                .padding(.vertical, 5)
            }
        }
        .onChange(of: photoPickerItems) { newItems in
            Task {
                for item in newItems {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        // Compress the image
                        if let compressedImage = compressImage(image) {
                            selectedPhotos.append(compressedImage)
                        }
                    }
                }
                photoPickerItems = []
            }
        }
        .sheet(isPresented: $showGallery) {
            if let photo = selectedPhoto {
                PhotoGalleryView(photo: photo)
            }
        }
    }
    
    private func compressImage(_ image: UIImage) -> UIImage? {
        let maxSize: CGFloat = 1024 // Maximum dimension
        let scale = min(maxSize / image.size.width, maxSize / image.size.height)
        
        if scale >= 1 {
            return image
        }
        
        let newSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let compressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return compressedImage
    }
}

struct PhotoThumbnail: View {
    let image: UIImage
    let onTap: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture(perform: onTap)
            
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.5))
                    .clipShape(Circle())
            }
            .padding(5)
        }
    }
}

struct PhotoGalleryView: View {
    @Environment(\.dismiss) var dismiss
    let photo: UIImage
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                GeometryReader { geometry in
                    Image(uiImage: photo)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(scale)
                        .offset(offset)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    let delta = value / lastScale
                                    lastScale = value
                                    scale = min(max(scale * delta, 1), 4)
                                }
                                .onEnded { _ in
                                    lastScale = 1.0
                                }
                        )
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    offset = CGSize(
                                        width: lastOffset.width + value.translation.width,
                                        height: lastOffset.height + value.translation.height
                                    )
                                }
                                .onEnded { _ in
                                    lastOffset = offset
                                }
                        )
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    PhotoPickerView(selectedPhotos: .constant([]))
} 